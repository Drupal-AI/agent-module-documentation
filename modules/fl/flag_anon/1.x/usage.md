Flag Anonymous shows anonymous visitors a configurable "Login or Register to use this flag" call-to-action (optionally in a popup) in place of a Flag link they don't have permission to use, converting would-be flaggers into registered users.

---

Flag Anonymous extends the contrib Flag module. For any flag you enable it on, when the current user is anonymous and lacks permission to perform the flag/unflag action, the module replaces the normal flag link with a message such as "@login or @register to use this flag", where the `@login` and `@register` placeholders become links to the user login and registration forms. It works by decorating Flag's `flag.link_builder` service with `FlagAnonLinkBuilder` (registered via `FlagAnonServiceProvider`), overriding `build()` to render a themed `flag_anon_message` element instead. All settings are stored as third-party settings on the individual Flag config entity (`flag.flag.*.third_party.flag_anon`), edited through an "Anonymous settings" section that the module adds to the flag edit form: enabled, label_display (keep the original label and show the message in a popin on click, or replace the label with the message), a message string, the login/register link labels, an optional dialog title, and options to open the login/registration forms in a modal popup with custom `data-dialog-options` JSON. The login/register links carry a `flag_anon=<flag_id>-<entity_id>` query parameter plus a destination; after the user authenticates, submit handlers on the login and register forms read that parameter and automatically perform the originally-intended flagging. Sites can add extra message placeholders via `hook_flag_anon_message_placeholders_alter()`.

---

- Prompt anonymous users to log in or register when they try to bookmark/favorite a node.
- Turn a "Like" flag into a conversion funnel that drives registrations from anonymous traffic.
- Show a "Login or Register to add to your wishlist" message on product pages to guests.
- Replace a hidden flag link with a call-to-action instead of showing nothing to anonymous users.
- Keep the original flag label and pop up a login/register message only when a guest clicks it.
- Open the login and registration forms in a modal dialog so users never leave the page.
- Auto-perform the intended flagging right after the visitor logs in or registers (via the flag_anon query param).
- Customize the login and register link text (e.g. "Sign in", "Join now") per flag.
- Set a friendly dialog title like "Attention" on the popin message.
- Tune modal size/behavior with per-flag `data-dialog-options` JSON (e.g. {"width":"auto"}).
- Use different anonymous messages for different flags (bookmark vs. follow vs. report).
- Encourage newsletter/community sign-ups by gating a "Follow" flag behind registration.
- Add custom placeholders (e.g. a routed link) to the message via hook_flag_anon_message_placeholders_alter().
- Increase engagement metrics by making flagging visibly available (as a CTA) to everyone.
- Localize the message and link labels through the flag config entity's translatable settings.
- Deploy the whole configuration as exported flag config (third_party_settings.flag_anon.*).
- Provide a consistent "join to participate" prompt across all flaggable entity types.
- Reduce confusion where anonymous users previously saw no flag control at all.
- Preserve the return destination so the user lands back on the page they flagged from.
- A/B different call-to-action copy by editing the flag's anonymous message.
- Combine with role-based flag permissions so only anonymous (permission-less) users see the CTA.
- Style the anonymous message independently using the `flag-anon-message` classes and library.
