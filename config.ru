require './config/environment'

use Rack::MethodOverride
use UsersController
use DreamsController
use KarmaController
run ApplicationController
