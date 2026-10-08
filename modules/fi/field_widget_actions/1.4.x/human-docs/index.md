# Field Widget Actions — manual setup guide

**Field Widget Actions** (`field_widget_actions`) is a framework for attaching
action **buttons** directly to field widgets on entity edit forms — nodes, media,
users, and any other fieldable entity. The classic example is a "Fill with AI" or
"Generate alt text" button sitting right next to the field it affects, but the
module itself is business-logic-agnostic: the same mechanism can trigger an ECA
workflow or any custom PHP you write.

Normally, putting a button next to one field means a hand-written form alter,
bespoke AJAX handling, custom markup, and a modal implemented from scratch. This
module turns all of that into a **plugin**. You (or a developer) implement a
`FieldWidgetAction` plugin once, and the module handles the UI integration, the
AJAX, the settings storage, and — when the action offers a list of choices — a
modal dialog where the editor picks the best result before it is applied. Actions
can target a single item in a multi-value field or the whole field at once, and the
shipped stylesheets include a Gin admin theme compatibility fix.

There are **no extra admin screens**: you decide which actions appear on which
fields directly from the standard **Manage form display** page. The base framework
has no module dependencies and already supports Drupal 10.3 through 12. The AI and
ECA integrations are optional — install those modules only if you want their
actions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus any optional integrations).

This module has **no dedicated settings page**. You attach actions to fields on the
field's **Manage form display**, described in "How to use it" below.

## Where it lives in the admin menu

Field Widget Actions adds no admin page of its own. You configure it entirely from
**Structure → *(your entity type)* → Manage form display**, on the individual
field widgets you want to add actions to.

## How to use it

1. Enable Field Widget Actions and at least one module that provides an action
   plugin — for example the **AI** module (for "Fill with AI" / "Generate alt
   text") or the **ECA** module (to trigger a workflow), or your own custom
   `FieldWidgetAction` plugin.
2. Go to the entity form you want to enhance — for a content type that is
   **Structure → Content types → *(type)* → Manage form display**.
3. Open the settings (the gear/cog) for the field widget you want to add a button
   to, and choose which action(s) should appear on it. Save the widget settings,
   then **Save** the form display.
4. Open an add/edit form for that entity. The action button now appears next to the
   field. Depending on the action, clicking it either fills the field directly or
   opens a modal offering suggestions you can choose from — and, for actions that
   support it, refine iteratively — before applying the result.

Developers writing their own actions implement the `FieldWidgetActionInterface`
(annotated with `@FieldWidgetAction`); the module takes care of the rest of the
integration.
