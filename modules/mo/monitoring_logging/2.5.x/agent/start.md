<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Monitoring Logging — agent index

Logs an **overview of Monitoring sensor results** to the Drupal log (time-stamped sensor-status
history; forward to SIEM/log aggregation). Depends on `monitoring`; ships
`monitoring_logging_check_drupal`. Version **2.5.0**. Core `^9.4||^10||^11`.

Administration/observability (no access role). Mind log volume with many frequent sensors.
