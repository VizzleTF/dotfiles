#!/usr/bin/env python3
import gi
import json
import sys

gi.require_version('Playerctl', '2.0')
from gi.repository import Playerctl, GLib

def on_metadata(player, metadata):
    """Обработчик изменения метаданных"""
    track_info = get_player_status(player)
    print(json.dumps(track_info), flush=True)

def on_play_pause(player, status):
    """Обработчик изменения статуса воспроизведения"""
    track_info = get_player_status(player)
    print(json.dumps(track_info), flush=True)

def get_player_icon(player_name):
    """Получить иконку приложения по имени плеера"""
    player_icons = {
        'spotify': '',
        'firefox': '󰈹',
        'chromium': '',
        'chrome': '',
        'vlc': '󰕼',
        'mpv': '',
        'rhythmbox': '󰓃',
        'clementine': '󰓃',
        'strawberry': '󰓃',
        'kdeconnect': '󰄡',
        'plasma-browser-integration': '󰈹',
    }

    name_lower = player_name.lower()
    for key, icon in player_icons.items():
        if key in name_lower:
            return icon

    return '󰝚'  # Иконка по умолчанию (музыкальная нота)

def get_player_status(player):
    """Получить информацию о текущем треке"""
    try:
        status = player.props.status
        player_name = player.props.player_name

        # Используем встроенные методы playerctl для получения данных
        artist = player.get_artist()
        title = player.get_title()

        if not title:
            return {"text": ""}

        # Определяем иконку в зависимости от статуса
        if status == 'Playing':
            status_icon = ''
        elif status == 'Paused':
            status_icon = ''
        else:
            status_icon = ''

        # Получаем иконку приложения
        app_icon = get_player_icon(player_name)

        # Формируем текст
        if artist:
            text = f"{artist} - {title}"
        else:
            text = title

        # Ограничиваем длину
        max_length = 40
        if len(text) > max_length:
            text = text[:max_length - 3] + "..."

        return {
            "text": f"{app_icon} {status_icon} {text}",
            "tooltip": f"{player_name}\n{artist}\n{title}" if artist else f"{player_name}\n{title}",
            "class": status.lower(),
            "alt": status
        }
    except Exception as e:
        return {"text": ""}

def on_name_appeared(manager, name):
    """Обработчик появления нового плеера"""
    init_player(manager)

def on_player_vanished(manager, player):
    """Обработчик исчезновения плеера"""
    print(json.dumps({"text": ""}), flush=True)

def init_player(manager):
    """Инициализация плеера"""
    try:
        # Получаем список всех плееров
        names = list(manager.props.player_names)

        if not names:
            print(json.dumps({"text": ""}), flush=True)
            return

        # Приоритет плееров (можно настроить под себя)
        priority = ['spotify', 'cmus', 'vlc', 'mpv', 'firefox', 'chromium']

        # Выбираем плеер по приоритету
        selected_name = None
        for p in priority:
            for name in names:
                if p in name.name.lower():
                    selected_name = name
                    break
            if selected_name:
                break

        # Если не нашли по приоритету, берём первый
        if not selected_name:
            selected_name = names[0]

        player = Playerctl.Player.new_from_name(selected_name)
        player.connect('metadata', on_metadata)
        player.connect('playback-status', on_play_pause)

        manager.manage_player(player)

        # Выводим начальный статус
        track_info = get_player_status(player)
        print(json.dumps(track_info), flush=True)

    except Exception as e:
        print(json.dumps({"text": ""}), flush=True)

def main():
    """Главная функция"""
    manager = Playerctl.PlayerManager()
    manager.connect('name-appeared', on_name_appeared)
    manager.connect('player-vanished', on_player_vanished)

    init_player(manager)

    # Запускаем главный цикл
    loop = GLib.MainLoop()
    loop.run()

if __name__ == "__main__":
    main()
