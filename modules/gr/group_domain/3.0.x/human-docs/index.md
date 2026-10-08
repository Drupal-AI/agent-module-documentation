# Group Domain — manual setup guide

**Group Domain** (`group_domain`) maps the current request's domain to a specific
[Group](https://www.drupal.org/project/group) and its content, so that on a
multi‑domain site each domain corresponds to a group and that group's content and
context apply for requests arriving on that domain. It bridges the Group module
with domain‑based multi‑site setups, which makes it a building block for
multi‑tenant and affiliate sites built on Group.

Where distinct domains should map to distinct groups — one domain per tenant, per
brand, or per affiliate — Group Domain ties the two together so that visiting a
domain surfaces that domain's group. A related module, Domain Group, integrates
Group with the full Domain module; Group Domain is the lighter option when you do
not need everything the Domain module brings.

> **Verify the mapping matches your intended isolation.** Because Group Domain ties
> a domain to a group's content and context, you should confirm that a domain
> surfaces only its group's content if that is your goal. And remember this is
> site‑structure plumbing that decides which group is active per domain — Group's
> own access controls still govern what members can actually do. Check the mapping
> after upgrades and when adding new domains or groups.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Group.

There is **no standalone settings form** for this module (`configure` is null). You
configure the domain‑to‑group mapping in the context of Group and your domains,
described under "How to use it" below.

## Where it lives in the admin menu

The module adds no central settings page of its own. You manage the
domain‑to‑group mapping through Group's own administration (**Groups** and group
configuration) together with your domain configuration. Its effect appears at the
request level: a request on a mapped domain surfaces that domain's group and
content.

## How to use it

1. Enable the module alongside the Group module and set up your domains.
2. Associate each **domain** with the **group** it should represent.
3. Requests on a mapped domain now surface that group's content and context.
4. Confirm the isolation you expect — that a domain surfaces only its group's
   content, if that is the goal — and rely on Group's permissions for what members
   can do within the group.
