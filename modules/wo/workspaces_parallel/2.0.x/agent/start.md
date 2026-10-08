<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Parallel Workspaces — agent index

Adds **support for parallel workspaces** (content in multiple workspaces simultaneously — concurrent staging
vs core's hierarchical model). `workspaces_parallel_graph` submodule. Depends on core `workspaces`. Version
**2.0.0-alpha2**. Core `^11.3`.

Automation/content-staging — access/publishing governed by Workspaces permissions (publishing a workspace
makes its content live — verify who can); no access role of its own.
