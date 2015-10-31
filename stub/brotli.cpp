/*
 * =====================================================================================
 *
 *       Filename:  brotli-helper.cpp
 *
 *    Description:  Provide a simple C interface to brotli
 *
 *        Created:  10/30/2015 15:04:57
 *       Compiler:  gcc
 *
 *         Author:  ajhl
 *
 * =====================================================================================
 */

#include <cstring.h>
#include <brotli/dec/decode.h>
#include <brotli/enc/encode.h>

extern "C" {

 int decompress_buffer(size_t encoded_size,const uint8_t* encoded_buffer,size_t* decoded_size, uint8_t* decoded_buffer)
 {
  

 }
 int compress_buffer(size_t input_size, const uint8_t* input_buffer,size_t* encoded_size, uint8_t* encoded_buffer);

}

