<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# calendar_event_notifications — agent orientation

- Content type `calendar_event_notification` + cron-driven e-mail reminders for appointments (add/update/delete/scheduled).
- Dependencies: fullcalendar_view, datetime_range, token. Package "Calendar event".
- Only route is admin settings `/admin/config/calendar-event-notifications` (`administer site configuration`); no anon endpoints.
- Fields of interest: field_event_date, field_notify_mail, field_user, field_cron_run_once; bundled View for FullCalendar.
- Mail sent via core MailManager with Token-templated body; nothing external, no security-sensitive surface.
