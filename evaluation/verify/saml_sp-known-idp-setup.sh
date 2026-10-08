#!/usr/bin/env bash
# Introspection SETUP: create an IdP config entity 'smlsp_known' with a known login URL so the
# agent can inspect the live saml_sp.idp.* config and read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\saml_sp\Entity\Idp;
  if (!Idp::load("smlsp_known")) {
    Idp::create([
      "id" => "smlsp_known", "label" => "Known IdP",
      "entity_id" => "https://idp.smlsp-eval.example/entity",
      "login_url" => "https://idp.smlsp-eval.example/sso/login",
      "logout_url" => "https://idp.smlsp-eval.example/sso/logout",
      "nameid_field" => "mail", "x509_cert" => [], "authn_context_class_ref" => [],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: IdP 'smlsp_known' created with login_url https://idp.smlsp-eval.example/sso/login"
