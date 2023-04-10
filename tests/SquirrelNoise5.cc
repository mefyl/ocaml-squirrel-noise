#include "SquirrelNoise5.hpp"

#include <caml/alloc.h>
#include <caml/memory.h>
#include "caml/mlvalues.h"


extern "C" {
  CAMLprim
  value
  int32_noise_1d(value seed, value x)
  {
    CAMLparam2(seed, x);
    CAMLlocal1(res);
    res = caml_copy_int32(Get1dNoiseUint(Int32_val(x),
                                         Int32_val(seed)));
    CAMLreturn(res);
  }

  CAMLprim
  value
  int32_noise_2d(value seed, value x, value y)
  {
    CAMLparam3(seed, x, y);
    CAMLlocal1(res);
    res = caml_copy_int32(Get2dNoiseUint(Int32_val(x),
                                         Int32_val(y),
                                         Int32_val(seed)));
    CAMLreturn(res);
  }

  CAMLprim
  value
  int32_noise_3d(value seed, value x, value y, value z)
  {
    CAMLparam4(seed, x, y, z);
    CAMLlocal1(res);
    res = caml_copy_int32(Get3dNoiseUint(Int32_val(x),
                                         Int32_val(y),
                                         Int32_val(z),
                                         Int32_val(seed)));
    CAMLreturn(res);
  }

  CAMLprim
  value
  int32_noise_4d(value seed, value x, value y, value z, value t)
  {
    CAMLparam5(seed, x, y, z, t);
    CAMLlocal1(res);
    res = caml_copy_int32(Get4dNoiseUint(Int32_val(x),
                                         Int32_val(y),
                                         Int32_val(z),
                                         Int32_val(t),
                                         Int32_val(seed)));
    CAMLreturn(res);
  }

  CAMLprim
  value
  zero_to_one_noise_1d(value seed, value x)
  {
    CAMLparam2(seed, x);
    CAMLlocal1(res);
    double d = Get1dNoiseZeroToOne(Int32_val(x),
                                   Int32_val(seed));
    res = caml_copy_double(d);
    CAMLreturn(res);
  }

  CAMLprim
  value
  neg_one_to_one_noise_1d(value seed, value x)
  {
    CAMLparam2(seed, x);
    CAMLlocal1(res);
    double d = Get1dNoiseNegOneToOne(Int32_val(x),
                                     Int32_val(seed));
    res = caml_copy_double(d);
    CAMLreturn(res);
  }
}
