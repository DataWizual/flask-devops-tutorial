# DevOps Infrastructure Template — Flask + CI/CD + Monitoring

## Кратко
Готовый к развёртыванию шаблон инфраструктуры:
- демо-приложение: Flask (пример `flaskr`)
- CI/CD: GitHub Actions (сборка образа и пуш на Docker Hub)
- Деплой: `deploy.sh` (одна команда для обновления контейнера)
- Monitoring: Prometheus + Grafana + cAdvisor
- Файлы: docker-compose, prometheus.yml, шаблоны Grafana

## Структура
```
packaged_solution/
├── app
│ ├── deploy.sh
│ ├── docker-compose.yml
│ ├── Dockerfile
│ ├── flaskr
│ │ ├── auth.py
│ │ ├── blog.py
│ │ ├── db.py
│ │ ├── init.py
│ │ ├── schema.sql
│ │ ├── static
│ │ │ └── style.css
│ │ └── templates
│ │ ├── auth
│ │ │ ├── login.html
│ │ │ └── register.html
│ │ ├── base.html
│ │ └── blog
│ │ ├── create.html
│ │ ├── index.html
│ │ └── update.html
│ ├── LICENSE.txt
│ ├── pyproject.toml
│ ├── README.md
│ ├── README.rst
│ └── tests
│ ├── conftest.py
│ ├── data.sql
│ ├── test_auth.py
│ ├── test_blog.py
│ ├── test_db.py
│ └── test_factory.py
├── ci
├── docs
├── monitoring
│ ├── docker-compose.yml
│ ├── grafana
│ └── prometheus
│ └── prometheus.yml
└── scripts
└── deploy.sh
```

## Быстрый старт (локально)
1. Запустить приложение, мониторинг и графану:
```bash
cd ~/devops_practice/packaged_solution/monitoring
docker compose up -d
# затем, в корне проекта (если есть docker-compose для всего стека)
# docker compose -f docker-compose.full.yml up -d
```

2. Деплой образа (локально, при наличии образа в Docker Hub):
cd ~/devops_practice/packaged_solution/scripts
./deploy.sh

3. Доступы:
Flask app: http://localhost:5000

Prometheus: http://localhost:9090

Grafana: http://localhost:3000 (admin/admin)

## Dashboard Customization (Grafana)

The included Grafana dashboard (`flask_monitoring_dashboard.json`)
is fully editable and optimized for a minimal cAdvisor + Prometheus setup.
You can easily adapt it to your environment or extend it with new panels.

### Legend Recommendations

| Panel | Suggested Legend | Description |
|-------|------------------|--------------|
| **Total CPU Usage (%)** | `{{job}}` | Displays which Prometheus job is providing CPU metrics. |
| **Total Memory Usage (MB)** | `Total` | Aggregate memory usage across all containers. |
| **Network Traffic (MB/s)** | `Receive` / `Transmit` | Two separate queries showing inbound and outbound traffic. |
| **System Uptime (seconds)** | `Uptime` | Shows the uptime of the Prometheus process. |
| **Prometheus Targets** | `{{instance}}` | Displays all monitored endpoints (Prometheus, Grafana, cAdvisor). |

### Visual Recommendations
- **Theme:** Dark (default for this template)
- **Time range:** `last 1 hour`
- **Auto-refresh:** every 5 seconds
- **Legend placement:** “Table” (bottom of panel)
- **Color thresholds:**
  - Green   — Normal  
  - Yellow  — Warning  
  - Red     — Critical  

### Example Layout
1. **Top row:** CPU / Memory / Network  
2. **Bottom row:** Uptime / Targets status  
3. **Optional:** add disk or system-load panels if node-exporter is available.

---

This dashboard layout is designed for a clean,
“presentation-ready” look — perfect for client demos or
infrastructure template sales.
