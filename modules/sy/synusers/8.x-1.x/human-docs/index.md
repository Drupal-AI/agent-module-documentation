# SynUsers — manual setup guide

**SynUsers** (`synusers`) is a vendor-specific custom users module in the
**SynapseF** package — part of a supplier's Drupal suite for managing users in that
vendor's context. Its public description is minimal ("Custom synusers"), so it is
not a general-purpose user-management add-on but a purpose-built piece of a larger
stack.

Because it is vendor-specific and lightly documented in public, and because user
handling can touch account creation, roles and authentication, you should review its
actual behaviour in the context of the SynapseF suite before relying on it — check
any user creation, role assignment or authentication paths it introduces. It has no
documented general-purpose access-control contract here and is not covered by the
security advisory policy. There are no submodules and no listed module dependencies.

This guide is written for a **human**. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

SynUsers registers no admin settings page (its `configure` route is null); it is
meant to operate as part of the SynapseF/vendor stack rather than as a standalone,
configurable module. Install it alongside the rest of that suite and consult the
vendor's own documentation for configuration. Because it deals with users, roles and
authentication, review its behaviour in your own environment before putting it into
production.
