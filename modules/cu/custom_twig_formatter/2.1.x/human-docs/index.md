# Custom Twig Formatter — manual setup guide

**Custom Twig Formatter** (`custom_twig_formatter`) provides a field formatter that
renders a field's output using **custom Twig code entered right in the formatter
settings** — no template files required. When you configure a field's display, you
write the Twig that produces its markup, and every field of the entity is exposed
as a Twig variable. That means you can shape one field's output using a combination
of values from other fields on the same entity, add conditional logic, insert
tokens, and craft exactly the markup you want, all from the admin UI.

It's a flexible, code-free-ish way to format fields for site builders who are
comfortable with Twig but don't want to create and manage theme templates. It
supports a wide range of field types — boolean, comment, date range, datetime,
entity reference, email, file, image, language, link, list, string/text, and
telephone — and support for more can be added. It depends only on Drupal core's
**Field** module and works on Drupal 9, 10, and 11.

**A word on trust and security.** Because this formatter evaluates
administrator-authored Twig, it is a **trusted-administrator capability**. Drupal
renders Twig through its **sandbox**, which restricts dangerous functions and
filters and significantly mitigates the risk — but whoever configures the formatter
can still craft arbitrary markup. So: restrict who can configure field displays
(the *Manage display* screens) to trusted users, and never expose the formatter
configuration to untrusted people. It has no content-access role — the field
content it renders still respects its own access rules.

Configuration is done per field on the *Manage display* screen; there is no global
settings page. See "How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no global settings
form. You set the Twig on each field's display, described below.

## Where it lives in the admin menu

Custom Twig Formatter adds no admin settings page of its own. You use it entirely
from **Structure → Content types (or any fieldable entity) → *(bundle)* → Manage
display**, where you choose it as a field's format and enter your Twig.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage display** screen for the entity/bundle whose field you want
   to format (for example **Structure → Content types → *(your type)* → Manage
   display**).
3. For the field in question, set its **Format** to **Custom Twig Formatter**.
4. Open the formatter's settings (the gear icon) and **write your Twig code**. All
   of the entity's fields are available as Twig variables, so you can combine
   values, add logic, and produce the exact markup you need.
5. Save the display, then view an entity to confirm the field renders as intended.

> **Keep it in trusted hands.** Anyone who can edit this formatter's settings can
> write Twig that shapes your site's output. Grant access to the *Manage display*
> screens only to administrators you trust, and don't expose this configuration to
> untrusted users.
