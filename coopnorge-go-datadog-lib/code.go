package main

import (
	"github.com/coopnorge/go-datadog-lib/middleware"
)

func main() {
	middleware.TraceUnaryServerInterceptor()
}
