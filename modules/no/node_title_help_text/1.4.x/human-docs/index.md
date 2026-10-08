# Node Title Help Text — manual setup guide

**Node Title Help Text** (`node_title_help_text`) lets you add a line of help text
underneath the **Title** field on a content type's add/edit form. Core lets you add
descriptions to most fields, but not to the built‑in Title field — this small module
fills that gap, so you can tell editors exactly what belongs in a title.

You set the help text per content type. Each type can carry its own guidance — for
example, "Use the format: Event — City — Date" on an Event, or "Keep under 60
characters for search results" on an Article. The text appears right under the title
box when someone creates or edits content of that type.

The module is careful and unobtrusive: it only fills in the title description when
nothing else has set one, so it never clobbers help text added by another module. It
also works inside **Inline Entity Form** widgets, so nested node forms get the same
guidance. There is no settings page, no permissions, and no code to write — each
content type simply carries its own optional help string as part of its
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it (no
   dependencies).

## Where it lives in the admin menu

There is no dedicated settings page. You add the help text on each content type's
edit form at **Structure → Content types → (your type) → Edit**
(`/admin/structure/types/manage/<type>`).

## How to use it

1. Go to **Structure → Content types** and click **Edit** on the type you want to
   add guidance to.
2. Open the **Submission form settings** vertical tab.
3. Fill in **Title field help text** — for example, "Enter a short, descriptive
   title." The form notes that this text appears at the bottom of the title field
   when creating or editing content of this type.
4. Click **Save content type**.

Now open that type's add form (**Content → Add content → your type**) and you will
see your help text sitting just below the Title field. Repeat for any other content
types that need their own guidance. Because the text is stored as part of the
content type's configuration, it exports and deploys with the rest of your site
config.
