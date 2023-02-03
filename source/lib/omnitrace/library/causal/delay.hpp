// MIT License
//
// Copyright (c) 2022 Advanced Micro Devices, Inc. All Rights Reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#pragma once

#include "library/common.hpp"
#include "library/components/fwd.hpp"
#include "library/defines.hpp"
#include "library/thread_data.hpp"

#include <timemory/components/base.hpp>
#include <timemory/macros/language.hpp>
#include <timemory/mpl/concepts.hpp>

#include <atomic>
#include <cstdint>

namespace omnitrace
{
namespace causal
{
struct delay
: tim::component::empty_base
, tim::concepts::component
{
    using value_type = void;

    OMNITRACE_DEFAULT_OBJECT(delay)

    static void    process();
    static void    credit();
    static void    preblock();
    static void    postblock(int64_t);
    static int64_t sync();

    static std::atomic<int64_t>& get_global();
    static int64_t&              get_local(int64_t _tid = threading::get_id());

    static int64_t  get(int64_t _tid = threading::get_id());
    static uint64_t compute_total_delay(uint64_t);
};
}  // namespace causal
}  // namespace omnitrace
