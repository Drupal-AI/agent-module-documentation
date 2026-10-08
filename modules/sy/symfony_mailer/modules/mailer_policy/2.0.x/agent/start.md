# mailer_policy — agent start

Configuration submodule of Mailer Plus. A `mailer_policy` **config entity** applies an ordered
stack of **EmailAdjuster** plugins to emails, targeted by email type tag. Depends on
`symfony_mailer`. Config UI: **Config → System → Mailer Plus → Policy**
(`/admin/config/system/mailer/policy`, route `entity.mailer_policy.collection`, permission
`administer mailer`).

- Create/edit policies (adjuster stacks, targeting) → [configure/policies.md](configure/policies.md)
- EmailAdjuster plugin type & built-ins → [plugins/email-adjuster.md](plugins/email-adjuster.md)
- Alter adjuster definitions → [hooks/hooks.md](hooks/hooks.md)
