require('sinatra')
require('sinatra/reloader')
require('./lib/word')
require('./lib/definition')
require('pry')
also_reload('lib/**/*.rb')

get('/') do
	@words = Word.all()
	erb(:index)
end

post('/new_word') do
	@new_word = Word.new(params.fetch('new_word'))
	@new_word.add()
	redirect('/')
end


get('/word/:id') do
	@word = Word.find(params.fetch('id').to_i())
	erb(:word)
end

post('/add_definition') do
	type = params.fetch('type')
	definition = params.fetch('new_definition')
	id = params.fetch('word_id')
	new_definition = Definition.new(type, definition)
	@word = Word.find(id.to_i())
	@word.add_definition(new_definition)
	redirect('/word/' + @word.id().to_s())
end
