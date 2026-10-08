# ECA Field Widget Actions — manual setup guide

**ECA Field Widget Actions** (`eca_field_widget_actions`) connects
[ECA](https://www.drupal.org/project/eca) (Event-Condition-Action) to the
[Field Widget Actions](https://www.drupal.org/project/field_widget_actions)
module. Field Widget Actions attaches action buttons next to form fields — for
example a "Suggest" button beside a text field. This module lets you define what
happens when such a button is clicked using an **ECA model** instead of custom PHP,
so field-widget behavior becomes no-code automation.

The flow is neat: you create an ECA model that starts with the **ECA Field Widget**
event, and the module automatically registers a matching Field Widget Action plugin
for that model. That plugin then appears in the list of available actions you can
attach to any field widget. When a user clicks the button on a form, the ECA event
fires with the current **entity**, **field name**, and **field index** as context;
your model evaluates its conditions and runs its actions — perhaps calling an
external API or processing the field's existing values — and can hand results back
to the widget using the **Set field widget value** action. This makes it a natural
fit for content suggestions, AI-assisted field filling, data lookups, or any value
that should be computed on demand.

The module affects form and widget behavior only — it has **no content or
access-control role**. There is no settings form; everything is configured in the
ECA modeller and on the field's widget settings. It depends on the ECA base module
(`eca`) and the Field Widget Actions module (`field_widget_actions`), and this
branch targets Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside ECA and Field Widget Actions.

There is **no configuration page** for this module — it has no settings form. You
wire behavior together in the ECA modeller and the field widget settings, described
in "How to use it" below.

## Where it lives in the admin menu

ECA Field Widget Actions adds no admin page of its own. You build models in the ECA
modeller at **Configuration → Workflow → ECA** (`/admin/config/workflow/eca`), and
you attach the resulting action to a field on that bundle's **Manage form display**
(**Structure → Content types → *(bundle)* → Manage form display**), where Field
Widget Actions adds its per-widget button settings.

## How to use it

1. In the ECA modeller at **Configuration → Workflow → ECA**, create a model whose
   starting event is the **ECA Field Widget** event.
2. Add conditions and actions to the model — for example, look something up and use
   the **Set field widget value** action to return one or more suggestions.
3. Go to the relevant bundle's **Manage form display** and, on the field whose
   widget should have the button, select the Field Widget Action that this module
   registered for your model.
4. Edit a piece of content: clicking the button on that field now fires your ECA
   model, with the entity, field name, and field index available as context.
