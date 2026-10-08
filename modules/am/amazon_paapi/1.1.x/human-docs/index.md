# Amazon PA-API — manual setup guide

**Amazon PA-API** (`amazon_paapi`) is a **helper** for talking to the **Amazon
Product Advertising API (PA-API 5)** from Drupal. Rather than being a
ready-to-use display feature, it provides a client that other code can use to
query Amazon product data — searching for products and looking up individual
items — for affiliate and product displays.

Think of it as the plumbing layer: it handles the AWS-signed requests to Amazon
so that a module or custom code built on top of it can fetch product
information. It provides its own permissions but does not add a content model or
access role of its own.

Every request to the PA-API is **AWS-signed** using an **access key**, a
**secret key**, and a **partner (associate) tag**. The access and secret keys
are credentials — store them as secrets in environment variables (or a Key
entity), never in committed configuration. Requests go out over HTTPS to Amazon,
so product lookups leave your server.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and provide your credentials.

## How to use it

This module is a client library rather than a point-and-click feature. After
enabling it, provide your Amazon PA-API **access key**, **secret key**, and
**partner tag** through environment variables (keeping the secret keys out of
committed configuration). Modules or custom code built on top of Amazon PA-API
then use its client to search Amazon and look up products.
