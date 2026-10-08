# Configuration

AI Site Manager has three surfaces: a **dashboard** where requests are typed and
previewed, a **settings** form, and an **audit history**. The most important
thing to understand is the two-step safety model that sits between a request and
any change to your site.

## Open the settings form

1. Log in as a user with the **administer AI site manager** permission.
2. Go to **Configuration → AI → Site Manager → Settings**, or navigate directly
   to `/admin/config/ai/site-manager/settings`.

On this form you set:

- **AI provider and model** — which provider/model (from the AI module) is used
  to interpret plain-English requests. If you leave this unconfigured, or the
  AI's confidence in a given request is too low, the module falls back to plain
  **keyword matching** so it still works. No API key is stored here; the key
  lives in the AI module's configuration as a secret.
- **Flood limit** — how many "Analyze" requests a single user may make in the
  window. This bounds how much AI-provider cost one account can run up.
  *Analyze* requests count toward the limit; confirmations do not.

Save the form to apply your changes.

## The dashboard and the two-step safety model

The dashboard lives at **Configuration → AI → Site Manager**
(`/admin/config/ai/site-manager`) and needs the **access AI site manager**
permission.

1. **Analyze.** You describe a task in plain English. The module interprets it
   into exactly one command, action, and set of parameters, then shows a
   human-readable **preview** together with a **risk level**. Nothing has changed
   on the site at this point. This step counts toward the flood limit.
2. **Confirm.** Only a user with the restricted **administer AI site manager**
   permission sees an active confirm button — and the permission is re-checked
   again when confirmation is submitted, and the action re-validated, before it
   actually runs. A preview-only user (access permission but not administer)
   can never execute anything.

Version 1 can carry out three kinds of command:

- **Module** — enable or uninstall a module.
- **Cache** — clear all caches.
- **Maintenance mode** — toggle it on or off.

## Audit history

Every interpretation and every execution is recorded. Review it at
**Reports → AI Site Manager History**
(`/admin/config/ai/site-manager/history`), which needs the **administer AI site
manager** permission. Each entry records who made the request, what command was
matched, and the outcome — a useful compliance trail for AI-suggested
administrative actions.

## Recommended setup

- Grant **access AI site manager** broadly if you want staff to be able to
  preview suggestions, but keep **administer AI site manager** to a small,
  trusted group, since that permission is what allows execution.
- Set a sensible **flood limit** to cap AI-provider cost per user.
- If you want LLM-quality interpretation rather than keyword matching, configure
  an AI provider and model — but remember requests are then sent to that
  provider.
