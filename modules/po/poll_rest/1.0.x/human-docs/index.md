# Poll Rest — manual setup guide

**Poll Rest** (`poll_rest`) makes Drupal's core **Poll** module work over the REST
API. It provides a REST endpoint through which a decoupled front end or an external
client can retrieve a poll's choices and results and submit or cancel votes — so
you can display polls and let people vote without rendering them through Drupal's
own theme layer.

It is a bridge between core Poll and Drupal's web-services stack, and it respects
Poll's own access rules: voting and viewing still follow the Poll module's
permissions, applied through REST. You configure the REST resource's permissions as
you would for any REST resource. It depends on core **Poll** and **REST**.

The endpoint supports the usual verbs: **GET** to read a poll's choices or its vote
results, **POST** to cast a vote for a choice, and **DELETE** to cancel the current
user's vote. Each response is JSON, and the vote/cancel operations run Poll's own
validation (for example, whether the user is allowed to vote).

Note that this module is **not covered by Drupal's security advisory policy**
(`security_advisory_coverage: not-covered`) — weigh that before exposing it on a
public or sensitive site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and turn on the poll vote REST resource.

The module has **no settings form of its own**. Its setup is done on core's REST
configuration page, described in "How to use it" below.

## Where it lives in the admin menu

Poll Rest adds no admin page of its own. You enable and configure its REST resource
from core's REST settings at **`/admin/config/services/rest`** (the interface there
is provided by the optional **REST UI** module).

## How to use it

1. After enabling the module (see [Installation](installation/index.md)), go to
   **`/admin/config/services/rest`** and enable the **poll vote** resource.
2. Enable the **GET**, **POST** and **DELETE** methods for that resource, and set
   the formats and authentication providers you need.
3. Set the resource's permissions so the right roles can read and vote — remember
   that voting still obeys the core Poll permissions.
4. Call the endpoint from your client. For example:
   - **Read choices:** `GET /api/v1/poll/1?query=choices`
   - **Read results:** `GET /api/v1/poll/1?query=votes`
   - **Vote:** `POST /api/v1/poll/1/vote` with a JSON body like `{"chid":"1"}`
   - **Cancel a vote:** `DELETE /api/v1/poll/1`
