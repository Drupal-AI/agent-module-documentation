# LocalGov Topics — manual setup guide

**LocalGov Topics** (`localgov_topics`) provides the shared **Topic** taxonomy
used across the LocalGovDrupal distribution to tag and group related content. The
idea is that instead of every section having its own tag vocabulary, all your
services, directories, and news share one consistent set of topics — so content
of different types can be grouped under a common theme and surfaced together on
topic hub pages.

The module is almost entirely configuration. Enabling it creates a taxonomy
vocabulary called **Topic** (`localgov_topic`), an unlimited-value node
entity-reference **field storage** (`localgov_topic_classified`) for tagging
nodes with topics, and — if Views is installed — an optional **Topics** view with
two entity-reference displays ("Private topics" and "Public topics") that topic
reference fields can use as their selection list.

There is no settings screen and no permissions of its own. The one small piece of
code grants LocalGov Editors permission to manage topic terms, but only when the
optional `localgov_roles` module is present. The field storage is created but not
attached to any content type, so the remaining setup is attaching the topic field
to the bundles that should carry topics (within LocalGovDrupal this is usually
done for you by the distribution's content-type modules).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the vocabulary, attaching the topic
   field to content types, the Topics reference view, and the roles integration.

## Where it lives in the admin menu

The module adds no settings page of its own. What it ships appears in the standard
places:

- The **Topic** vocabulary and its terms are managed at **Structure → Taxonomy →
  Topic** (`/admin/structure/taxonomy/manage/localgov_topic/overview`).
- The topic field is attached and configured under each content type's **Manage
  fields**.

## How to use it

After enabling, make a content type topic-taggable by adding the
`localgov_topic_classified` field to it, then create your topic terms in the Topic
vocabulary. Editors can then tag content with one or more topics, and you can
build topic landing pages or related-content listings that aggregate everything
sharing a topic. See [Configuration](configuration/index.md) for the details.
