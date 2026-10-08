<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Monitoring Logging outputs an overview of Monitoring sensor results to a log, recording sensor status over time.

---

Monitoring Logging extends the Monitoring module by writing an overview of sensor results to the
Drupal log. Monitoring runs "sensors" that check site health (failed logins, queue sizes, errors,
etc.); this module records their results to the log channel, giving a time-stamped history of sensor
status that can be reviewed or shipped to external log aggregation. It depends on the `monitoring`
module and ships a `monitoring_logging_check_drupal` submodule.

Use it where you want Monitoring's sensor outcomes persisted to logs — for audit, trend analysis, or
forwarding to a SIEM/log platform. It is an administration/observability feature; it reads sensor
results and logs them, with no access-control role. Consider log volume if many sensors run
frequently.

---

- Log Monitoring sensor results.
- Record sensor status over time.
- Give a time-stamped sensor history.
- Forward sensor outcomes to log aggregation.
- Depend on the Monitoring module.
- Review sensor trends via logs.
- Ship results to a SIEM.
- Persist site-health checks.
- Use the monitoring_logging_check_drupal submodule.
- Audit sensor status.
- Write an overview to the log channel.
- Track failed-login or queue sensors.
- Support observability.
- Analyse health trends.
- Log Monitoring outcomes for compliance.
- Mind log volume with many sensors.
- Read sensor results and log them.
- Have no access-control role.
- Integrate Monitoring with logging.
- Record health-check history.
