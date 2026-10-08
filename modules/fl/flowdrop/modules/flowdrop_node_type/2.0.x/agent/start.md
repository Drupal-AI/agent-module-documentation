<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop Node Type (flowdrop_node_type) — agent index

Submodule of **flowdrop**. Entity defining **which node plugins the editor offers** and how each
is configured. Version **2.0.0**. Core `^11.3`.

Node types as *entities* rather than pure plugin definitions is the design point: a site can add,
configure and restrict them without code — expose an HTTP node but not a raw-PHP one, preconfigure
an AI node with an approved model and system prompt, hide what is irrelevant. The palette becomes
curated rather than "everything the code offers".

**Worth checking in a security review**: which node types a site exposes is an authorisation
decision, since node types are what a workflow author can make the server do.

Pairs with `flowdrop_node_category` (palette grouping) and `flowdrop_node_processor` (the built-in
plugins).