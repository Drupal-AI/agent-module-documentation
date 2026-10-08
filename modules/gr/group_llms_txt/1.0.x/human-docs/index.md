# Group LLMs.txt — manual setup guide

**Group LLMs.txt** (`group_llms_txt`) connects the
[LLMs.txt](https://www.drupal.org/project/llms_txt) module with the
[Group](https://www.drupal.org/project/group) module, so each group can have its
own `llms.txt`. An `llms.txt` file is an emerging convention that tells AI
crawlers and large language models which content to use and how — think of it as a
guidance file for LLMs, scoped here to a single group's content.

Concretely, the module makes the LLMs.txt module's `llms_txt_section` entities
manageable as **group content**. That means each group can own its own llms.txt
sections, with group-specific permissions and access control applying to them,
rather than there being one site-wide file only.

This is an SEO / AI-discoverability feature. The llms.txt reflects the group's
content, which continues to follow Group's own access rules, and the module has no
access-control role of its own — it simply lets you author and scope the guidance
per group.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Group and LLMs.txt.

There is **no central settings form**. You manage llms.txt sections per group as
group content, described under "How to use it" below.

## Where it lives in the admin menu

Group LLMs.txt adds no settings page of its own. It surfaces llms.txt sections as
**group content**, which you manage from within each group (and control through
that group type's group content permissions). The site-wide LLMs.txt behavior
itself lives in the LLMs.txt module.

## How to use it

1. Enable the module (this needs both Group and LLMs.txt — see
   [Installation](installation/index.md)).
2. Enable the llms.txt section group content plugin on the group type(s) you want,
   via the group type's **Content** tab.
3. From inside a group, add and manage its llms.txt sections as group content.

Each group can then expose its own group-scoped llms.txt guidance, governed by the
group's own permissions.
