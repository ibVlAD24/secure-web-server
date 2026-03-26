#!/bin/bash

# Очищаем все существующие правила
iptables -F

# Устанавливаем политики по умолчанию
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

# Разрешаем локальный интерфейс (чтобы не сломать себе доступ)
iptables -A INPUT -i lo -j ACCEPT

# Разрешаем уже установленные соединения (чтобы ответы на наши запросы проходили)
iptables -A INPUT -m state --state ESTABLISHED, RELATED -j ACCEPT

# Разрешаем доступ к веб-серверу ТОЛЬКО с твоего IP
iptables -A INPUT -p tcp --dport 8080 -s 10.0.2.15 -j ACCEPT

# Логируем все остальные попытки доступа на порт 8080
iptables -A INPUT -p tcp --dport 8080 -j LOG --log-prefix 'WEB_ATTAK: '

# Всё остальное блокируется политикой DROP

