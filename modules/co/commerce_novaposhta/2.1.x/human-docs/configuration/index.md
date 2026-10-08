# Configuration

Setting up Commerce Novaposhta has a few parts: enter your API key on the module
settings form, add a Nova Poshta shipping method, make sure your products carry
dimensions and weight, and enable the Novaposhta address field for the customer
profile.

## 1. Enter your API key

1. Go to **Configuration → Web services → Commerce Novaposhta**
   (`/admin/config/services/commerce-novaposhta`). This page is gated by the
   restricted **Administer commerce novaposhta configuration** permission — grant it
   only to trusted admins.
2. Enter your **Nova Poshta API key** and save.

> **A note on how the key is stored.** In this version the API key is saved in the
> module's plain configuration rather than a Key entity. If you export
> configuration, take care not to commit the real key — consider overriding it per
> environment (for example via `settings.php`) so the secret stays out of version
> control. API calls are made over HTTPS with normal certificate verification.

## 2. Add product dimension and weight fields

Nova Poshta prices by parcel size and weight, so add the **Physical** dimension and
weight field types to every shippable product type and populate them on your
products. Without accurate dimensions/weight the rate query will be off.

## 3. Add the Nova Poshta shipping method

1. Go to **Commerce → Configuration → Shipping methods**
   (`/admin/commerce/shipping-methods`) and add a shipping method.
2. Choose the **Nova Poshta** plugin and save. Delivery cost is then calculated by
   calling the Nova Poshta API at checkout.

## 4. Enable the Novaposhta address field for the customer profile

So customers can pick their city and branch, enable the module's custom Novaposhta
field on the relevant profile type at **Configuration → People → Profile types →
*(manage the customer profile type)***
(`/admin/config/people/profile-types/manage/PROFILE_TYPE`) — tick the option that
profiles of this type include a Novaposhta address. The module provides a custom
field type, widget and formatter that let the shopper search and select a
settlement/city and a Nova Poshta warehouse; the selection is stored on the order.

## How it behaves

At checkout the customer selects their city and branch, and the module queries Nova
Poshta for the delivery price. Cities, areas and warehouses are cached and
searchable. Developers can adjust request or result data via the module's alter
hooks.
