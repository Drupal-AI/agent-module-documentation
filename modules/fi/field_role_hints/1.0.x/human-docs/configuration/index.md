# Configuration

Field Role Hints is configured in **two places**: a global settings form that sets
the defaults and scope, and a per‑field section where you write the actual hints.

## 1. Global settings

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → Field role hints**, or navigate
   directly to `/admin/config/content/field-role-hints`.

The form has three settings:

- **Default hint mode** — how a role hint combines with the field's existing
  description. Choose one:
  - **Append role hint to existing help text** — the hint is added below the
    field's normal description (separated by a line break).
  - **Replace existing help text with role hint** — the hint takes the place of
    the field's normal description entirely.
  This is only the *default*; each field can override it (see below).
- **Enabled entity types** — which entity types may use role hints. **Node** is
  enabled by default; tick additional entity types here if you want the per‑field
  hints UI to appear on their fields too.
- **Role priority order** — the tie‑breaker for editors who belong to several
  roles. When more than one of a user's roles has a hint for a field, the
  hint from the **highest‑priority** role in this list is the one shown. Order the
  roles from most to least specific so the right guidance wins.

Click **Save configuration** when done.

## 2. Per‑field hints

Once an entity type is enabled, every field on it gains a **Field role hints**
section on its edit form (**Structure → … → Manage fields → *(field)***):

- **Enable role‑based hints for this field** — the master switch for this field.
  Leave it off and the field behaves normally.
- **Mode (append / replace)** — optionally override the global default for just
  this field.
- **Per‑role help text** — a text box for each role. Fill in only the roles that
  need tailored guidance; empty roles fall back to the field's normal description.

Save the field configuration. From then on, editors see the hint that matches
their highest‑priority role, appended to or replacing the field's description as
configured.

## How resolution works

When an editor opens the form, the module finds the field's widget, works out
which of the editor's roles has a hint, and picks the one ranked highest in the
**role priority order**. That single hint is then appended to or replaces the
field `#description`. Multi‑value and compound widgets are handled so the hint
lands on the correct input.

> **Visibility reminder.** Hints are shown as ordinary form help text, and the
> full set of per‑role hints is visible to anyone who can edit the field's
> configuration. Don't use hint text to store anything sensitive.
