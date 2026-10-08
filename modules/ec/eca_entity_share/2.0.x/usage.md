<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Entity Share exposes Entity Share's content-syndication events to the ECA rules engine so imports and channel listings can be automated without custom PHP.

---

ECA Entity Share integrates the **ECA** (Events-Conditions-Actions) module with **Entity Share**, the module that syndicates content between Drupal sites over JSON:API. It provides no functionality on its own screens; instead it registers two Entity Share Symfony events as ECA event plugins through two hidden submodules. Enable **ECA Entity Share Client** (`eca_entity_share_client`) to react to the *Relationship Field Value* event that fires while a client site imports remote entities and resolves their entity-reference relationships, and enable **ECA Entity Share Server** (`eca_entity_share_server`) to react to the *Channel list prepared* event that fires while a server site assembles the list of channels it offers. In an ECA model you start a workflow from one of these events and then read or alter the event's data (the field item list and field value on the client side, or the channel-list array on the server side) with ordinary ECA conditions and actions. The top-level `eca_entity_share` module is a hidden package holder; the submodules require ECA `^2.0 || ^3.0` and Entity Share `^3.0 || ^4.0` on Drupal `^10.4 || ^11`.

---

- Trigger an ECA model whenever an Entity Share client imports a relationship field value.
- Trigger an ECA model whenever an Entity Share server prepares its list of channels.
- Automate content syndication between Drupal sites without writing an event subscriber in PHP.
- Alter a referenced entity's field value during import from within an ECA model.
- Log or audit each relationship field processed during an Entity Share import run.
- Conditionally skip or rewrite reference targets that point to entities not present on the client.
- Notify an editor or channel when specific content is imported via Entity Share.
- Add a computed or default value to a field as remote entities are pulled in.
- Dynamically add extra channels to a server's channel list at request time from an ECA model.
- Remove or hide channels from a server's advertised channel list based on ECA conditions.
- Reorder or relabel channels presented to Entity Share client sites.
- Restrict which channels are exposed depending on the current request context, evaluated in ECA.
- Enrich imported entity references with tokens or lookups configured in an ECA model.
- Kick off follow-up ECA actions (email, queue item, HTTP call) after a channel list is built.
- Build low-code content-distribution workflows that span a publisher (server) and subscriber (client) site.
- Standardize import behavior across many content types using a single reusable ECA model.
- Debug Entity Share imports by inspecting relationship field values inside ECA.
- React to channel preparation to inject environment-specific channel definitions.
- Coordinate multi-site publishing pipelines driven by ECA rather than bespoke code.
- Combine Entity Share events with other ECA events, conditions, and actions in one model.
