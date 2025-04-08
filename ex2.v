Require Import prelude.
Require Import ex1.

Section proof.
Context `{hG: heapGS Σ, !ffi_semantics _ _, !goGlobalsGS Σ}.

Lemma concurrentExample_spec :
  ❴ is_pkg_init demo ❵
    "demo" @ "concurrentExample" #()
  ❴ returns (); True ❵.
Proof.
  wp_start. wp_auto.
  wp_apply_core (wp_fork with "[x]"); [wp_pures|].
  { wp_auto. done. }
  wp_pures.
  wp_apply (primitive.wp_fork with "[y]").
  {
    wp_apply foo_spec'. done.
  }
  by iApply "HΦ".
Qed.

End proof.
