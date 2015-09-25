m = require('mochainon')
path = require('path')
os = require('os')
rsync = require('../lib/rsync')

describe 'Rsync:', ->

	it 'should throw if no source', ->
		m.chai.expect ->
			rsync.getCommand
				uuid: '1234'
		.to.throw('source is required')

	it 'should throw if source is not a string', ->
		m.chai.expect ->
			rsync.getCommand
				uuid: '1234'
				source: [ 'foo', 'bar' ]
		.to.throw('source must be of string type')

	it 'should throw if no uuid', ->
		m.chai.expect ->
			rsync.getCommand
				source: 'foo/bar'
		.to.throw('uuid is required')

	it 'should throw if uuid is not a string', ->
		m.chai.expect ->
			rsync.getCommand
				uuid: 1234
				source: 'foo/bar'
		.to.throw('uuid must be of string type')

	it 'should throw if uuid is empty', ->
		m.chai.expect ->
			rsync.getCommand
				uuid: ''
				source: 'foo/bar'
		.to.throw('uuid must not be empty')

	it 'should throw if progress is not a boolean', ->
		m.chai.expect ->
			rsync.getCommand
				uuid: '1234'
				source: 'foo/bar'
				progress: 'true'
		.to.throw('progress must be of boolean type')

	it 'should throw if ignore is not a string nor array', ->
		m.chai.expect ->
			rsync.getCommand
				uuid: '1234'
				source: 'foo/bar'
				ignore: 1234
		.to.throw('ignore must be of string,array type')

	it 'should interpret an empty source as .', ->
		command = rsync.getCommand
			uuid: '1234'
			source: ''

		m.chai.expect(command).to.equal [
			'rsync'
			'-azr'
			'--rsh=\"ssh -p 80 -o \\\"ProxyCommand nc -X connect -x vpn.resin.io:3128 %h %p\\\" -o StrictHostKeyChecking=no\"'
			'.'
			'root@1234.resin:/data/.resin-watch'
		].join(' ')

	it 'should interpret an source containing only blank spaces as .', ->
		command = rsync.getCommand
			uuid: '1234'
			source: '      '

		m.chai.expect(command).to.equal [
			'rsync'
			'-azr'
			'--rsh=\"ssh -p 80 -o \\\"ProxyCommand nc -X connect -x vpn.resin.io:3128 %h %p\\\" -o StrictHostKeyChecking=no\"'
			'.'
			'root@1234.resin:/data/.resin-watch'
		].join(' ')

	it 'should automatically append a slash at the end of source', ->
		command = rsync.getCommand
			uuid: '1234'
			source: 'foo'

		m.chai.expect(command).to.equal [
			'rsync'
			'-azr'
			'--rsh=\"ssh -p 80 -o \\\"ProxyCommand nc -X connect -x vpn.resin.io:3128 %h %p\\\" -o StrictHostKeyChecking=no\"'
			"foo#{path.sep}"
			'root@1234.resin:/data/.resin-watch'
		].join(' ')

	it 'should not append a slash at the end of source is there is one already', ->
		command = rsync.getCommand
			uuid: '1234'
			source: "foo#{path.sep}"

		m.chai.expect(command).to.equal [
			'rsync'
			'-azr'
			'--rsh=\"ssh -p 80 -o \\\"ProxyCommand nc -X connect -x vpn.resin.io:3128 %h %p\\\" -o StrictHostKeyChecking=no\"'
			"foo#{path.sep}"
			'root@1234.resin:/data/.resin-watch'
		].join(' ')

	it 'should be able to set progress to true', ->
		command = rsync.getCommand
			uuid: '1234'
			source: 'foo/bar/'
			progress: true

		m.chai.expect(command).to.equal [
			'rsync'
			'-azr'
			'--progress'
			'--rsh=\"ssh -p 80 -o \\\"ProxyCommand nc -X connect -x vpn.resin.io:3128 %h %p\\\" -o StrictHostKeyChecking=no\"'
			'foo/bar/'
			'root@1234.resin:/data/.resin-watch'
		].join(' ')

	it 'should be able to set progress to false', ->
		command = rsync.getCommand
			uuid: '1234'
			source: 'foo/bar/'
			progress: false

		m.chai.expect(command).to.equal [
			'rsync'
			'-azr'
			'--rsh=\"ssh -p 80 -o \\\"ProxyCommand nc -X connect -x vpn.resin.io:3128 %h %p\\\" -o StrictHostKeyChecking=no\"'
			'foo/bar/'
			'root@1234.resin:/data/.resin-watch'
		].join(' ')

	it 'should be able to exclute a single pattern', ->
		command = rsync.getCommand
			uuid: '1234'
			source: 'foo/bar/'
			ignore: '.git'

		m.chai.expect(command).to.equal [
			'rsync'
			'-azr'
			'--rsh=\"ssh -p 80 -o \\\"ProxyCommand nc -X connect -x vpn.resin.io:3128 %h %p\\\" -o StrictHostKeyChecking=no\"'
			'--exclude=.git'
			'foo/bar/'
			'root@1234.resin:/data/.resin-watch'
		].join(' ')

	it 'should be able to exclute a multiple patterns', ->
		command = rsync.getCommand
			uuid: '1234'
			source: 'foo/bar/'
			ignore: [ '.git', 'node_modules' ]

		m.chai.expect(command).to.equal [
			'rsync'
			'-azr'
			'--rsh=\"ssh -p 80 -o \\\"ProxyCommand nc -X connect -x vpn.resin.io:3128 %h %p\\\" -o StrictHostKeyChecking=no\"'
			'--exclude=.git'
			'--exclude=node_modules'
			'foo/bar/'
			'root@1234.resin:/data/.resin-watch'
		].join(' ')
