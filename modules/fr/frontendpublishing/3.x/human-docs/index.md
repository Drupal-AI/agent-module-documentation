# Frontend Publishing — manual setup guide

**Frontend Publishing** (`frontendpublishing`) provides an API for an integrated
publishing workflow that runs on the rendered front end of your site rather than in
the admin back end. It gives editors an in-context editorial experience: a
JavaScript interface that shows dialogs, backed by REST endpoints that handle the
publish and edit requests via AJAX. An optional scheduler submodule adds
time-based publishing to the mix.

This is a developer-facing framework more than a click-and-go feature — it supplies
the JavaScript interface and the REST endpoints that a front-end (or a decoupled
theme) calls to let people manage content from the page they are looking at. If you
are building an in-context editing experience, this module is the plumbing.

One thing to keep firmly in mind: publishing, editing, and scheduling from the
front end are **content-mutating operations**. They must enforce the same access as
the equivalent admin actions. A front-end publishing UI should never let a user do
something they could not do in the admin — actions have to be genuinely
access-checked on the server, not merely hidden in the interface. When you wire this
up, verify that the workflow respects each user's real edit and publish permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies,
   and enable the optional scheduler submodule.

There is **no dedicated settings form** for this module. It exposes an API (a
JavaScript interface plus REST endpoints) that you integrate into your front end,
so setup happens in your theme/front-end code rather than on an admin page.

## How to use it

At a high level, you enable the module, then call its JavaScript interface from your
front end to open the publishing dialogs; those dialogs talk to the module's REST
endpoints to carry out the edit/publish/schedule actions. Enable the
`frontendpublishing_scheduler` submodule if you also need scheduled (time-based)
publishing. As you build the integration, confirm every front-end action is gated by
the acting user's actual content permissions.
