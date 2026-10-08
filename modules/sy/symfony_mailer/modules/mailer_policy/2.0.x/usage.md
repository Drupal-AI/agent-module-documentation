Mailer Policy is the configuration submodule of Mailer Plus: it stores `mailer_policy` config entities that apply an ordered stack of EmailAdjuster plugins (From, To, Subject, theme, inline CSS, convert-to-plain, and more) to emails, targeted by email type.

---

A **policy** is a config entity keyed by an email type/sub-type tag (e.g. `_` for all mail,
`user`, `user__password_reset`, `contact.page`). Each policy holds a list of **EmailAdjuster**
plugins with their settings, executed in weight order during the appropriate email phase.
Adjusters cover the whole message: addressing (`from`, `to`, `cc`, `bcc`, `reply_to`,
`sender`), content (`subject`, `body`), presentation (`theme`, `inline_css`,
`inline_images`, `wrap_and_convert`/`plain`), delivery (`transport`, `priority`,
`skip_sending`), and URL handling (`absolute_url`). Because policies are config entities they
are exportable and deployable, and they resolve hierarchically — a setting on `_` applies
everywhere unless a more specific policy overrides it. Site builders manage them at
Configuration → System → Mailer Plus → Policy; developers add new adjuster types with the
`#[EmailAdjuster]` attribute or alter the set with `hook_mailer_adjuster_info_alter()`. This
submodule is what makes Mailer Plus configurable rather than code-only, and the Mailer
Override submodule ships ready-made policies for core, Contact, Commerce, and Simplenews mail.

---

- Set a site-wide From name and address for all outgoing email.
- Give password-reset emails their own subject and theme.
- Add a global BCC address to every email for archival.
- Apply a custom email theme/template to a specific email type.
- Inline CSS on HTML emails so styling survives email clients.
- Embed (inline) images into an email rather than linking them.
- Convert selected emails to plain text with a wrap-and-convert adjuster.
- Set the Reply-To address for contact-form notifications.
- Override the To address of an email based on policy.
- Skip sending a particular email type entirely.
- Set email priority headers per email type.
- Choose which transport a given email type should use.
- Rewrite relative URLs in the body to absolute ones.
- Configure the Sender header separately from From.
- Add a standard signature/body wrapper to all emails.
- Deploy consistent email configuration across environments as config.
- Override a broad `_` default policy with a type-specific one.
- Set different From addresses for user emails vs. commerce emails.
- Add Cc recipients to internal notification emails.
- Localize subject/body per email type on multilingual sites.
- Reuse an adjuster programmatically inside a phase hook.
- Add a custom EmailAdjuster plugin for bespoke email tweaks.
- Alter available adjuster plugins with `hook_mailer_adjuster_info_alter()`.
- Configure Simplenews or Contact email appearance via shipped policies.
