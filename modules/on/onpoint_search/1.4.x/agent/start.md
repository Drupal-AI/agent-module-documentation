<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OnPoint Search — agent index

Integrates the **OnPoint hosted search** service — site search backed by OnPoint instead of a local
index. Config at `onpoint_search.settings`; `onpoint_search_d8` submodule; provides permissions.
Version **1.4.0-alpha1**. Core `^9||^10||^11`.

Store OnPoint credentials as secrets; query terms/content go to the external service (SaaS
dependency).
