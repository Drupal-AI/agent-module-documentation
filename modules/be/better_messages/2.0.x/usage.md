Better Messages restyles Drupal's status/warning/error messages as animated, positionable popups that can auto-close, be dragged/resized, and be shown only on selected pages via visibility conditions.

---

The module takes core's `status_messages` output and enhances it with JS/CSS driven by a single
config object, `better_messages.settings`. An admin form (route `better_messages.settings_form`
at `/admin/config/user-interface/better-messages`, gated by the `configure better messages`
permission) controls where the message box appears (`position` — e.g. center/top-right, with
`vertical`/`horizontal` offsets and a `fixed` toggle), its `width`, animation in/out
(`popin`/`popout` effect + duration), auto-close behaviour (`autoclose` seconds,
`disable_autoclose`, `show_countdown`, `hover_autoclose`, `opendelay`), and jQuery UI
enhancements (`jquery_ui.draggable`, `jquery_ui.resizable` — hence the module's
`jquery_ui_draggable`/`jquery_ui_resizable` dependencies). A `visibility` setting stores standard
Drupal **condition** plugin configuration (request path, etc.) so Better Messages can be limited
to, or excluded from, particular pages. The module also ships a custom **Condition plugin**
(`message_type`, "Message type") whose context is the current Better Messages, plus a
`context_provider` service (`better_messages.context`) that exposes the current messenger
messages as a context — letting other conditions/blocks react to which message types are present.
It provides no field, no entity and no Drush; its only persistent state is the
`better_messages.settings` config. Defaults ship in `config/install/better_messages.settings.yml`
(position `center`, width `400px`, autoclose off, draggable on, resizable off, fade in/out slow).

---

- Turn Drupal's plain status messages into animated popup/toast notifications.
- Position the message box (center, a corner, top/bottom) with pixel offsets.
- Make messages auto-close after N seconds with a visible countdown.
- Keep a message open while the mouse hovers over it (`hover_autoclose`).
- Let users drag the message box around the screen (jQuery UI draggable).
- Let users resize the message box (jQuery UI resizable).
- Set a fixed-position message overlay that stays put while scrolling.
- Choose fade/slide in and out animations and their durations.
- Add a short open delay before messages appear.
- Set a custom width for the message container.
- Show messages only on specific pages using request-path visibility conditions.
- Exclude the message popup from certain admin or checkout pages.
- Disable auto-close entirely so errors stay until dismissed.
- Provide a more prominent, accessible confirmation after form submissions.
- Improve UX on long forms by surfacing validation errors as a centered popup.
- Standardize notification styling across a site's themes.
- React to which message types (status/warning/error) are present via the `message_type` condition.
- Expose current messages as context to other condition/block plugins (`better_messages.context`).
- Gate message-box configuration to trusted roles with the `configure better messages` permission.
- Export the popup configuration as config for consistent deployment across environments.
- Give editors a friendlier "saved!" toast after saving content.
- Tune animation speed to be subtle or attention-grabbing depending on the site.
- Show a countdown timer so users know when a toast will disappear.
- Roll out a site-wide notification look-and-feel without custom theme JS.
