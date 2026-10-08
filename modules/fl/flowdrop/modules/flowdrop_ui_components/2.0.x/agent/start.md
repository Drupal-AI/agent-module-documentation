<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop UI Components (flowdrop_ui_components) — agent index

Submodule of **flowdrop**, and a **hard dependency of the main module** — present on every FlowDrop
site. Supplies the **SDC** the dashboard and admin screens are built from.
Version **2.0.0**. Core `^11.3`.

Components observed: `pill`, `status-badge`, `progress-bar`, `action-link`, `grid`, `page-header`,
`detail-section`, `data-viewer`, `plugin-selector`, `job-timeline`.

**Environment caveat to pass on:** these components are enumerated by anything that discovers SDC.
With **Canvas** also enabled, Canvas's `ComponentMetadataRequirementsChecker` ran over them and
tripped `assert($property !== NULL)`, fataling the container build (see `canvas_field_component`).
Nothing here is wrong — FlowDrop was fine once Canvas was removed — but it matters on a site
running both.