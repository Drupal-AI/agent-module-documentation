# AI Sorting — manual setup guide

**AI Sorting** (`ai_sorting`) adds a **Views sort plugin** that orders results
using an AI / reinforcement-learning model rather than a fixed field. The model
learns from how people interact with your listings and adapts the ordering over
time, so a view can present results by learned relevance instead of, say, a
static date or title sort.

It depends on core's **Views** and on the **RL** (reinforcement learning)
module, which supplies the model. There is no settings page of its own — you use
it by adding the AI sort to a view in the Views UI.

The data-handling point to be aware of is that reinforcement learning **learns
from user interactions** — that is behavioural data, so handle it in line with
your privacy policy. If the RL model makes any external calls, that is egress to
consider as well. The module has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Views and RL.

## Where it lives in the admin menu

There is no dedicated configuration page. The plugin appears in the **Views UI**
(**Structure → Views**, `/admin/structure/views`) as a sort option you add to a
view, the same way you would add any other sort criterion.

## How to use it

1. Edit or create a view under **Structure → Views**.
2. In the view's **Sort criteria**, add the AI / reinforcement-learning sort
   provided by this module.
3. Save the view. Results are then ordered by the learned relevance model, which
   adapts as users interact with the listing.

Because the sort learns from user behaviour, make sure that data collection is
covered by your privacy policy, and review the ordering to confirm it behaves
sensibly for your content before relying on it in production.
