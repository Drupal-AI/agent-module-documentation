# Auto Node Translate Amazon provider — manual setup guide

**Auto Node Translate Amazon provider** (`auto_node_translate_amazon`) plugs
[Amazon Translate](https://aws.amazon.com/translate/) into the
[Auto Node Translate](https://www.drupal.org/project/auto_node_translate) module,
so machine translations of your node content can be produced by AWS.

Auto Node Translate does all the Drupal-side work — deciding which fields to
translate, when translation is triggered, and how the result is saved — and hands
the actual translating off to a *provider* plugin. This small module supplies the
AWS provider: a translator plugin plus a settings form where you enter the AWS
credentials and region it needs. Once configured, **Amazon** appears as one of the
choices wherever Auto Node Translate asks which provider to use, and translation
requests are sent to the AWS API using the source and target languages from your
Drupal language configuration.

The module is deliberately tiny — just a plugin and a settings form — because
everything else belongs to the parent module. If you want to compare providers or
keep translation costs on an existing AWS bill, this is how you add Amazon to the
mix.

Because it deals with AWS credentials, handle them carefully: store the keys in
environment variables rather than committing them to exported configuration. The
[Configuration](configuration/index.md) page explains how.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Auto Node Translate.
2. [Configuration](configuration/index.md) — enter your AWS credentials and
   region, and select Amazon as a translation provider.

## Where it lives in the admin menu

The module's settings form is its `configure` route,
`auto_node_translate_amazon.settings`, reachable from the admin menu under the
Auto Node Translate configuration area. Everything else — which fields translate
and when — is configured on the parent Auto Node Translate module.
