# Configuration

## Open the admin UI

1. Log in as a user with one of the module's context permissions (they are all
   restricted, trusted permissions — see below).
2. Go to **Configuration → AI → Context** (`/admin/config/ai/context`).

From here you manage **context items** (the content itself) and review **usage**
(where context was actually applied). Because context steers what your AI agents do,
grant these permissions — such as **Administer AI context**, **View AI context
items**, and **Create AI context item** — only to trusted roles.

## Create a context item

A context item holds one reusable piece of background — for example your
organisation's tone-of-voice guidelines, a product's key facts, or an editorial
policy. Create one, write its content (you can author in **Markdown** for
readability), and save it.

Because context items are moderated content:

- You can **draft and review** them through Content Moderation before they go live,
  so guidance is checked before it can influence an agent.
- You can **translate** them, giving multilingual agents the right context per
  language.
- With the Scheduler and Diff integrations you can **schedule** context changes and
  **compare** two versions of an item.

## Give the item a scope

A **scope** decides *where* a context item applies. When you attach one or more
scopes to an item, the module can select it intelligently based on several criteria
at once. The shipped scopes are:

- **Global** — the context applies everywhere.
- **Entity bundle** — apply it only for a specific content type (or other bundle).
- **Target entity** — apply it for one specific entity.
- **Language** — provide different context per language.
- **Site section** — attach context to a particular section of the site.
- **Tag** — tag context items and select them by tag.

Combine scopes to target context precisely — for example, tone-of-voice guidance
scoped to a language, plus product knowledge scoped to a particular content type.

> Developers can add their own scopes: the module defines an `AiContextScope` plugin
> type. See the [`agent/`](../agent/start.md) docs for the plugin attribute and base
> class.

## Review context usage

The second entity type, **context usage**, records where context was actually used
in a prompt. It has its own list and Views data, so you can:

- **See which context reached which prompt**, to debug why an agent produced a
  particular answer.
- **Report on usage** with Views.
- **Audit** context usage for compliance and to catch stale guidance before it
  causes problems.

## Notes

- All permissions are restricted because context content directly shapes agent
  behaviour — treat editing rights as you would any high-trust content permission.
- The module blocks its own uninstall while context data still exists, so remove
  your context items first if you ever need to uninstall it.
