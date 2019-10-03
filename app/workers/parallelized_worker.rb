class ParallelizedWorker
  include Sidekiq::Worker

  def perform(n)
    n.times do |i|
      Individual.perform_async i.to_s
    end
  end

  class Individual
    include Sidekiq::Worker

    def perform(i)
      Sidekiq.logger.info i
    end
  end
end
