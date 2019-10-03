class BogoWorker
  include Sidekiq::Worker

  def perform(n)
    return if n <= 0

    self.class.perform_async n - 1
  end
end
