# Configuration

There are two things to know about configuring Entity Dependency Visualizer: you
must **enable Dependency Calculation** before the graph will work, and you can
optionally **customize how the graphs look**.

## Enable Dependency Calculation

On Drupal 8 and above the module does **not** calculate dependencies until you turn
that on manually. This is a deliberate step — dependency calculation can be work for
the server, so it's opt‑in. Enable it, and the **"Content dependencies"** tab on
your entities will start producing graphs.

## Customize graph appearance

The module provides a configuration page where you can adjust the appearance of the
generated graphs to your preferences. Open it, set the display options you want, and
save; the changes apply to the graphs rendered on the "Content dependencies" tab.

## Performance note

To keep large sites responsive, the initial graph is limited to a maximum nesting
depth of **100 items** — enough for a manageable overview without risking timeouts
or heavy server load. You aren't restricted to that first view, though: you can keep
**drilling down** into child items from within the chart to explore deeper
relationships on demand.

## Grant access

The module provides its own permission. Make sure the roles that should be able to
view dependency graphs have it (under **People → Permissions**), so the "Content
dependencies" tab is available to the right users.
