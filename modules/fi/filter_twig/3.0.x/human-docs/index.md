# Filter Twig — manual setup guide

**Filter Twig** (`filter_twig`) adds a text-format filter that runs a field's content
through Drupal's Twig engine when the field is rendered. In practice that means Twig
syntax typed into a field — `{{ … }}` expressions, `{% for %}` loops, `{% if %}`
conditionals, Twig filters and functions — is evaluated and replaced with its output.
It lets a trusted admin drop small templating snippets directly into a body or block
without editing theme files: computed markup, a quick list built from a loop,
Twig globals like the current date, and so on.

The module ships a single filter plugin (id `filter_twig`, labelled "Replaces Twig
values") with no settings. You turn it on by ticking it on a text format at
**Configuration → Content authoring → Text formats and editors**; any field using
that format then renders its stored text as a Twig template. There is no
configuration UI, no permission, no route, and no service of its own — the only knob
is whether the filter is enabled on a given format, and its position in that format's
filter pipeline. Its one dependency is core's **Filter** module.

> ## Security — read this before enabling
>
> This filter **executes Twig from field content**, which is effectively code
> execution. Anyone who can edit a field that uses a Twig-enabled text format can run
> arbitrary Twig. **Only enable it on formats whose "use" permission is restricted to
> trusted/administrative roles** (for example a dedicated admin-only format). **Never**
> enable it on a format available to untrusted or anonymous users — such as a default
> comment or "Basic HTML" format — because that would hand low-privilege users
> arbitrary Twig execution. Treat any Twig-enabled format as a sensitive,
> code-execution surface and grant its use permission accordingly.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings page of its own. You enable the filter on a text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

1. Enable the module.
2. Go to **`/admin/config/content/formats`** and edit (or add) a text format —
   ideally a dedicated admin-only format, or one like *Full HTML* whose use
   permission is already limited to trusted roles.
3. Under **Enabled filters**, tick **"Replaces Twig values"** (`filter_twig`).
4. **Save.** Fields that use that format now render their content as Twig.

**Filter ordering matters.** Because Twig Filter is a transform, where it sits in the
pipeline (its weight) affects the result when combined with HTML-restricting filters:
run Twig *before* filters that would strip the markup it produces, and remember that
a "Limit allowed HTML tags" filter can still strip Twig's output afterward.

**Confirm the format's use permission is safe.** After enabling the filter, check
**People → Permissions** and make sure the *Use the [format] text format* permission
for that format is granted only to trusted roles. To instantly stop all Twig
evaluation for that format, untick the filter (or restrict the format's use
permission).

For developers: the filter simply builds an `inline_template` render element from the
stored text and returns the rendered result, so everything available to that Twig
environment executes. There are no hooks, services, or plugin types to implement
against — the only integration point is enabling the filter on a format.
