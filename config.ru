require './config/environment'

use Rack::MethodOverride
use UsersController
use DreamsController
run ApplicationController
