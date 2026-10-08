# Action Link — manual setup guide

**Action Link** (`action_link`) is a developer and site-building framework for
building links that *do something* when clicked. Think of the kind of link that
toggles a "favourite" flag, moves a piece of content to the next workflow state,
or updates a field value — a single click that changes state, optionally without
a full page reload (via AJAX). If you have used the Flag module, Action Link is
the same idea generalised: a reusable way to define any state-changing link, not
just flags.

Out of the box the base module gives you the framework and the plumbing; the
actual links you build are defined as configuration. Five optional submodules
extend it for common cases: **Entity links**, **Field links**, **Formatter
links**, a **proof-of-concept** demo, and **Workflow** links (which drive content
moderation transitions). It depends on the **Declarative Form Ajax**
(`declarative_form_ajax`) module and requires Drupal 10.3 or 11.

Because an action link **changes state when it is followed**, security is part of
using it correctly. Each action you build must be access-controlled — Action
Link ships its own permissions so you can gate who may perform an action — and
protected against forged requests using Drupal's CSRF tokens, so a link cannot be
triggered by an attacker who tricks a logged-in user into loading a crafted URL.
Keep that in mind whenever you define a custom action on top of the framework.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Declarative
   Form Ajax dependency, enable it, and pick the submodules you need.

## How to use it

Action Link is a framework rather than a point-and-click feature, so most of the
work happens when you define an action link (in configuration or code) and place
it where editors will use it — for example rendered next to a piece of content or
as a field formatter. The typical steps are:

1. Enable the base module plus the submodule that matches your case — **Workflow**
   for content-moderation transitions, **Field links** or **Formatter links** to
   surface actions on entity fields, **Entity links** for entity operations.
2. Define your action link and its behaviour.
3. Grant the relevant Action Link permission to the roles that should be allowed
   to perform the action (under **People → Permissions**), so the action is
   access-controlled.
4. Confirm the link uses a CSRF-protected route so it cannot be triggered by a
   forged request.

The proof-of-concept submodule (`action_link_poc`) is a working example you can
enable to see the framework in action before building your own.
