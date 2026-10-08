Chatlio embeds the Chatlio.com live-chat widget on your Drupal site, with per-page visibility conditions and optional logged-in-user identification.

---

Chatlio is a thin integration for the third-party Chatlio.com live-chat service (a Slack-connected support chat widget). You paste the JavaScript embed code Chatlio gives you into the module's settings, and the module injects that code into the bottom of every rendered page via `hook_page_bottom()`. Where the widget appears is controlled by standard Drupal condition plugins (pages/paths, roles, node and taxonomy bundles, and — on multilingual sites — language), configured on one admin settings form. It can also optionally hide the widget on mobile devices and on admin routes, and pass the current logged-in user's name/email (via tokens) to the widget so support agents see who they are chatting with. The module provides no entities, permissions, Drush commands, or plugin types of its own; all configuration lives in the single `chatlio.settings` config object.

---

- Add a Chatlio.com live-chat / support widget to a Drupal site without writing theme code.
- Paste the vendor embed snippet once in the UI instead of editing `html.html.twig` or a block.
- Turn the whole chat widget on or off site-wide with a single "Enable Chatlio" checkbox.
- Show the widget only on specific paths (e.g. `/contact`, `/products/*`) using the request-path condition.
- Hide the widget on selected paths while showing it everywhere else (negated request-path condition).
- Restrict chat to visitors in particular roles (e.g. anonymous only, or authenticated only).
- Limit the widget to specific content types (node bundles) such as product or landing pages.
- Limit the widget to specific taxonomy-term pages via the taxonomy-term bundle condition.
- Show the widget only for chosen languages on a multilingual site.
- Suppress the chat widget on admin/back-office pages (default) or explicitly enable it there.
- Disable the widget on mobile devices to keep small screens uncluttered.
- Pass the logged-in user's username to Chatlio so agents see who is chatting.
- Pass the logged-in user's email to Chatlio for follow-up and identification.
- Use Drupal tokens (e.g. `[current-user:name]`, `[current-user:mail]`) to customize the identity strings.
- Provide sales/support chat on marketing pages while keeping documentation pages chat-free.
- Run a support widget scoped to logged-in customers only (role condition) for account areas.
- Roll out chat to a single-language segment of a multilingual site during a pilot.
- Centralize widget management for site admins under Configuration -> Web services.
- Export the widget configuration (code + visibility conditions) with configuration management for staging-to-prod deployment.
- Temporarily pull the widget from all pages during maintenance by unchecking one box.
- Keep cache-correct output: rendering respects visibility conditions' cache tags/contexts automatically.
