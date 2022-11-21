package something

import (
	"github.com/coopnorge/go-datadog-lib/middleware"
)

func MyServer() {
	middleware.TraceUnaryServerInterceptor()
}
