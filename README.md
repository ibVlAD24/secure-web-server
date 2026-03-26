# 🔒 Защищённый веб-сервер

[![GitHub stars](https://img.shields.io/github/stars/ibVLAD24/secure-web-server?style=for-the-badge)](https://github.com/ibVLAD24/secure-web-server/stargazers)
[![GitHub license](https://img.shields.io/github/license/ibVLAD24/secure-web-server?style=for-the-badge)](LICENSE)
[![Made with Ubuntu](https://img.shields.io/badge/Made%20with-Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](https://ubuntu.com/)

## 📌 О проекте

Этот проект демонстрирует настройку **защищённого веб-сервера** с использованием **iptables** для ограничения доступа по IP-адресу.  
Сервер доступен **только с одного разрешённого IP**, все остальные попытки подключения логируются.

### 🎯 Что делает проект:
- ✅ Веб-сервер на Python (порт 8080)
- ✅ Политика **DROP** по умолчанию (всё запрещено)
- ✅ Разрешён доступ только с IP `10.0.2.15`
- ✅ Логирование всех попыток подключения на порт 8080

---

## 🛠️ Технологии

| Технология | Назначение |
|------------|------------|
| **Ubuntu 22.04** | Операционная система |
| **Python 3** | Встроенный HTTP-сервер |
| **iptables** | Файервол, фильтрация трафика |
| **Git** | Контроль версий |

---

## 🚀 Быстрый старт

### 1️⃣ Запуск веб-сервера
```bash
python3 -m http.server 8080
```

### 2️⃣ Применение правил iptables
```bash
sudo bash config/iptables-rules.sh
```

### 3️⃣ Проверка доступа с разрешённого IP
```bash
curl http://localhost:8080
```
✅ Должен показаться HTML-код

### 4️⃣ Имитация атаки
```bash
telnet localhost 8080
```
❌ В логах появится запись:
```
WEB_ATTAK: ... SRC=127.0.0.1 ... DPT=8080 ...
```

---

## 📸 Демонстрация

| Успешный доступ | Логирование атаки | Правила iptables |
|-----------------|-------------------|------------------|
| ![Скриншот 1](screenshots/access-allowed.png) | ![Скриншот 2](screenshots/log-attack.png) | ![Скриншот 3](screenshots/iptables-rules.png) |

*(Скриншоты будут добавлены позже)*

---

## 📂 Структура проекта

```
secure-web-server/
├── config/
│   ├── iptables-rules.sh      # Скрипт настройки защиты
│   └── iptables-rules.backup  # Бекап правил (опционально)
├── screenshots/               # Скриншоты работы
└── README.md                  # Документация
```

---

## 🔐 Как это работает

### Правила iptables

| Правило | Описание |
|---------|----------|
| `:INPUT DROP` | Всё, что не разрешено — запрещено |
| `-A INPUT -i lo -j ACCEPT` | Разрешить локальные соединения |
| `-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT` | Разрешить уже установленные соединения |
| `-A INPUT -s 10.0.2.15/32 -p tcp --dport 8080 -j ACCEPT` | Разрешить доступ с твоего IP |
| `-A INPUT -p tcp --dport 8080 -j LOG` | Логировать все попытки на порт 8080 |

### Схема прохождения пакета

```
[Интернет] → [Твой компьютер]
                ↓
         [iptables INPUT]
                ↓
    ┌─────────────────────────────────┐
    │ 1. Пакет от 10.0.2.15:8080?    │ → ✅ РАЗРЕШИТЬ
    │ 2. Пакет от любого на 8080?     │ → 📝 ЗАЛОГИРОВАТЬ
    │ 3. Любой другой пакет?          │ → ❌ ЗАБЛОКИРОВАТЬ
    └─────────────────────────────────┘
```

---

## 📝 Логи атак

Все попытки подключения с неразрешённых IP попадают в `/var/log/kern.log`:

```
WEB_ATTAK: IN=lo OUT= ... SRC=1.2.3.4 DST=127.0.0.1 ... DPT=8080 ...
```

---

## 📎 Полезные ссылки

- [Документация iptables](https://netfilter.org/documentation/)
- [GitHub проекта](https://github.com/ibVLAD24/secure-web-server)

---

## 🧑‍💻 Автор

**ibVLAD24** — студент направления 10.05.03 "Информационная безопасность"

[![GitHub](https://img.shields.io/badge/GitHub-ibVLAD24-181717?style=flat-square&logo=github)](https://github.com/ibVLAD24)

---

## 📄 Лицензия

Этот проект распространяется под лицензией MIT.

=======

