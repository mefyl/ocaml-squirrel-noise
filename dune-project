(lang dune 3.0)

(name squirrel-noise)

(version 5)

(generate_opam_files true)

(executables_implicit_empty_intf true)

(license CC-BY-3.0)

(maintainers "mefyl <mefyl@gruntech.org>")

(authors "mefyl <mefyl@gruntech.org>")

(homepage https://github.com/mefyl/ocaml-squirrel-noise)

(bug_reports https://github.com/mefyl/ocaml-squirrel-noise)

(source
 (github mefyl/ocaml-squirrel-noise))

(package
 (name squirrel-noise)
 (synopsis
  "Implementation of the squirrel noise function from Squirrel Eiserloh")
 (description
  "Implementation of the version 5 of the Squirrel noise function as presented at GDC: https://youtu.be/LWFzPP8ZbdU.")
 (depends
  ; Test
  (alcotest :with-test)
  (ocaml
   (>= 4.05.0))))
