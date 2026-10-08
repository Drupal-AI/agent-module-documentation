Status Messages turns Drupal's ordinary status/warning/error messages into a floating popup ("toast") in the top-right corner of the page that fades out automatically after a configurable number of seconds.

---

The module attaches a small CSS/JS library (`status_messages/status-messages`) to every page (`hook_page_attachments`) and re-renders the core status messages so they display as a floating popup with a close button. A single admin setting, `status_message_time` (stored in the `status_messages.status_messages` config object), controls how long a message stays before fading out; it is passed to JavaScript via `drupalSettings.statusMessages` in `hook_preprocess`. The value is in **milliseconds** and the settings form offers 5000 (5s), 10000 (10s), 15000 (15s), 20000 (20s) and 3600000 ("Never" — effectively no auto-close). The form lives at `/admin/config/user-interface/status-messages` (route `status_messages.status_messages`), gated by the `administer status messages configuration` permission. The module also re-points the `status_messages` theme hook to its own template and, via `hook_preprocess_block__system_messages_block`, refreshes the messages block content with `max-age: 0`. It ships no config schema and no default config, so `status_message_time` is unset until an admin saves the form. It has no module dependencies.

---

- Show Drupal's "Your changes have been saved" message as a floating toast.
- Auto-dismiss status messages after 5 seconds so they don't clutter the page.
- Keep error messages on screen longer by choosing 20 seconds.
- Disable auto-close (set "Never") so users must dismiss messages manually.
- Give form confirmations a modern popup feel without theming work.
- Provide a close (×) button on status messages.
- Standardise message auto-dismiss timing across the whole site.
- Improve UX on admin forms that produce many status messages.
- Move messages out of the content flow to the top-right corner.
- Fade messages out smoothly instead of leaving them until page reload.
- Reduce visual noise after AJAX-heavy interactions that add messages.
- Present warning messages as attention-grabbing toasts.
- Configure a short 10-second display for transient success notices.
- Let editors see save confirmations without scrolling to the top of the page.
- Apply a consistent popup style to messages site-wide via one setting.
- Turn off the default message CSS (the module handles presentation).
- Use on a decoupled-ish admin theme where inline messages look out of place.
- Keep critical messages visible until dismissed by choosing "Never".
- Give a cleaner post-submission experience on public-facing forms.
- Speed up perceived responsiveness by auto-hiding old messages.
