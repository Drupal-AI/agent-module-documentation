# NetForum xWeb API — manual setup guide

**NetForum xWeb API** (`netforum`) connects Drupal to **NetForum**, an
association-management system (AMS), through its **xWeb SOAP web service**. It is
primarily a developer-friendly SDK: it abstracts away the complexity of SOAP
communication and xWeb authentication and gives you clean, object-oriented PHP
interfaces for running queries and consuming NetForum data — so a site can sync
members, events, and other association data with NetForum.

Under the hood it uses the WsdlToPhp/PackageGenerator library to generate
strongly-typed PHP proxy classes from NetForum's WSDL. It ships a standard set of
generated proxy classes for common xWeb operations based on the public WSDL, and
because associations often customize their NetForum implementation, it also
supports generating **custom proxy classes** from your association's specific WSDL.

This module is a foundation for building integrations rather than a turnkey feature
— expect to write code that calls its services. What it needs from an administrator
is a set of **xWeb API credentials** for your NetForum environment. Those are
secrets: store them securely, never commit them to your repository, and always
connect over HTTPS. The module runs on Drupal 10.4 and 11 and is maintained by
HigherBits LLC.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — supply your NetForum xWeb credentials
   and connection details, stored securely.

## Where it lives in the admin menu

NetForum xWeb API's value is its PHP service layer, which developers call from
custom code. Its connection credentials are administered through the module's
settings; enter them there before any integration code can authenticate to
NetForum.
