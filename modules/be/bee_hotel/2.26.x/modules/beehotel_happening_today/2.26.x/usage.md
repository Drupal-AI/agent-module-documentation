BeeHotel Happening Today builds a daily arrivals/departures/tasks report for a property and emails it automatically on cron.

---

This submodule gives front-desk and housekeeping staff a daily operational summary: today's arrivals and departures, in-progress stays, guests who arrived yesterday, rooms that need cleaning and guests leaving tomorrow. A DailyReportGenerator composes the report from DataProcessor/UnitProcessor/OrderService/ReportBuilder services; hook_cron sends it by email at the configured time to the configured recipients (respecting a once-per-day guard). The settings form (/admin/beehotel/config/services/beehotel-happening-today) sets send time, recipients, subject, format and a test email; the report is also viewable at /admin/beehotel/happening-today. Config object beehotel_happening_today.settings has a schema.

---

- Email reception a daily summary of what is happening at the property.
- List today's arrivals (guests checking in).
- List today's departures (guests checking out).
- Show in-progress reservations still ongoing.
- Flag rooms that need cleaning after checkout.
- Highlight guests who arrived yesterday for follow-up.
- Warn which guests are leaving tomorrow.
- Schedule automatic sending at a configured time via cron.
- Send to multiple recipient email addresses.
- Customise the email subject and HTML/plain format.
- Send a test report to verify configuration.
- View the report on demand at /admin/beehotel/happening-today.
