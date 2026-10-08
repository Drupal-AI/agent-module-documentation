# Ajax requirement — manual setup guide

**Ajax requirement** (`ajax_requirement`) is a Form API utility that lets a
field's *required* state respond dynamically to other inputs. Whether a field is
required can change as the visitor fills in the form — updated via AJAX and
Form API `#states` — instead of being fixed when the form is built.

It exists for conditional-requirement forms: "if X is selected, Y becomes
required." Without a helper, wiring that up cleanly takes custom JavaScript and
careful validation handling. Ajax requirement provides the plumbing so you can
express the dependency in your form definition.

It is a developer/forms utility. It affects only validation and required
behavior — it has no content or access-control role — and there is no settings
page. You apply it within the form definitions where the conditional logic
belongs.

This guide is written for a **human** installing and using the module. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

After enabling, use the utility in your own form code to make a field's required
state depend on other inputs, so the requirement updates dynamically as the user
interacts with the form — no custom JavaScript needed for the required logic.
See the [`agent/`](../agent/start.md) docs and the project page for how to apply
it in a form definition.
