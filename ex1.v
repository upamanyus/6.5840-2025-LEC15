Require Import prelude.

Section proof.
Context `{hG: heapGS Σ, !ffi_semantics _ _, !goGlobalsGS Σ}.

Lemma foo_spec :
  ❴ is_pkg_init demo ❵
    "demo" @ "foo" #()
  ❴ (x : w64), returns x; ⌜ uint.Z x > 0 ⌝ ❵.
Proof.
  wp_start as "Hpre".
  wp_alloc x_ptr as "Hx".
  wp_pures.
  wp_store.
  wp_pures.
  wp_load.
  wp_pures.
  wp_store.
  wp_pures.
  wp_load.
  wp_pures.
  wp_load.
  wp_pures.
  by iApply "HΦ".
Qed.

Lemma foo_spec' :
  ❴ is_pkg_init demo ❵
    "demo" @ "foo" #()
  ❴ (x : w64), returns x; ⌜ uint.Z x > 0 ⌝ ❵.
Proof.
  wp_start as "Hpre".
  wp_auto. by iApply "HΦ".
Qed.

End proof.
